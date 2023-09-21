import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/models.dart';

class RecipeThumbnail extends StatefulWidget {
  final SimpleRecipe recipe;
  const RecipeThumbnail({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeThumbnail> createState() => _RecipeThumbnailState();
}

class _RecipeThumbnailState extends State<RecipeThumbnail> {
  DBHelper dbHelper = DBHelper();
  SimpleRecipe? recipeFavorited;
  bool _isFavorited = false;

  @override
  void initState() {
    // print("Halo");
    _getRecipe(widget.recipe.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${widget.recipe.dishImage}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_sharp),
                      color: (_isFavorited ? Colors.red : Colors.grey),
                      onPressed: () async {
                        if (dbHelper == await null) {
                          print("Erorr");
                        } else {
                          if (_isFavorited) {
                            dbHelper.deleteRecipe(widget.recipe.id.toString());
                            setState(() {
                              _isFavorited = !_isFavorited;
                              // _getRecipe(widget.recipe.id.toString());
                            });
                            final snackBar = SnackBar(
                              content: Text(
                                  "${widget.recipe.title} dihapus dari favorit."),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            dbHelper.addResep(widget.recipe);
                            setState(() {
                              _isFavorited = !_isFavorited;
                              _getRecipe(widget.recipe.id.toString());
                            });
                            final snackBar = SnackBar(
                              content: Text(
                                  "${widget.recipe.title} ditambahkan ke favorite."),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                        // Testing
                        // List? fav = await dbHelper.getAllRecipes();
                        // print(fav.toString());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.recipe.title.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.recipe.duration.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Future<void> _getRecipe(String id) async {
    var recipe = await dbHelper.getRecipe(id);
    setState(() {
      recipeFavorited = SimpleRecipe(
          recipe?.id.toString(),
          recipe?.dishImage.toString(),
          recipe?.title.toString(),
          recipe?.duration.toString(),
          recipe?.source.toString(),
          recipe?.information);
      if (recipeFavorited?.id.toString() == widget.recipe.id) {
        _isFavorited = true;
      } else {
        _isFavorited = false;
      }
    });
  }
}
