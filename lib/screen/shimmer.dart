Shimmer.fromColors(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 16),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 96,
                    child: Row(
                      children: [
                        Container(
                          height: 96,
                          width: 96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white
                                borderRadius: BorderRadius.circular(16)
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  );
                }),
            baseColor: baseColor,
            highlightColor: highlightColor)