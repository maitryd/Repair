import 'package:demandium/core/core_export.dart';
import 'recent_search.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecentSearch(),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
        ],
      ),
    );
  }
}
