import 'package:flutter/material.dart';

import 'package:swipperdeneme/slidder_model.dart';

class Slidder extends StatefulWidget {
  final List<SlidderModel> data;
  final ValueChanged<SlidderModel>? onChange;
  final Function? onTap;
  double margin;
  Color activeIndicatorColor;
  Color backgroundColor;
  Color? titleColor;
  Color? descriptionColor;
  Slidder(
      {Key? key,
      required this.data,
      this.onChange,
      this.onTap,
      this.margin = 16,
      this.activeIndicatorColor = Colors.deepOrange,
      this.backgroundColor = const Color.fromARGB(255, 5, 43, 74),
      this.titleColor = Colors.white,
      this.descriptionColor = Colors.white54})
      : super(key: key);

  @override
  State<Slidder> createState() => _SlidderState();
}

class _SlidderState extends State<Slidder> with TickerProviderStateMixin {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.margin, bottom: widget.margin),
      child: Column(
        children: [
          SizedBox(
              height: 310,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.7),
                itemCount: widget.data.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });

                  widget.onChange!(widget.data[selectedIndex]);
                },
                itemBuilder: (context, index) {
                  var _scale = selectedIndex == index ? 1.0 : 0.8;
                  return TweenAnimationBuilder(
                    curve: Curves.easeIn,
                    tween: Tween(begin: _scale, end: _scale),
                    builder: (context, double value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    duration: const Duration(milliseconds: 250),
                    child: slidderItem(widget.data[index]),
                  );
                },
              )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...List.generate(
                widget.data.length,
                (index) => indicator(
                      isActive: index == selectedIndex ? true : false,
                      activeIndicatorColor: widget.activeIndicatorColor,
                    ))
          ])
        ],
      ),
    );
  }

  GestureDetector slidderItem(SlidderModel item) {
    return GestureDetector(
      onTap: () => widget.onTap!(item),
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(item.url.toString()),
              ),
              borderRadius: BorderRadius.circular(25)),
          child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: const Alignment(0.0, 0.2),
                  end: const Alignment(0.0, 0.5),
                  colors: <Color>[
                    const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    widget.backgroundColor,
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item.title.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            color: widget.titleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            item.description.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.descriptionColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

class indicator extends StatelessWidget {
  bool? isActive;
  Color activeIndicatorColor;
  indicator({
    Key? key,
    this.isActive,
    required this.activeIndicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 12, 2, 6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isActive! ? 22.0 : 8.0,
        height: 8.0,
        decoration: BoxDecoration(
            color: isActive! ? activeIndicatorColor : Colors.grey,
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
