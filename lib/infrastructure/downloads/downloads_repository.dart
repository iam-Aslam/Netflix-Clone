import 'dart:developer';

import 'package:netflix_clone/domain/core/api_end_points.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:netflix_clone/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';

@LazySingleton(as: IDownloadsRepo)
class DownloadsRepository implements IDownloadsRepo {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImage() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndpoints.downloads);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final downloadsList = (response.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();

        // final List<Downloads> downloadsList = [];
        // log(response.data.toString());
        // for (final raw in response.data) {
        //   downloadsList.add(Downloads.fromJson(raw as Map<String, dynamic>));
        // }
        print(downloadsList);
        return Right(downloadsList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}




// ignore_for_file: unused_import

// import 'dart:math';

// import 'package:injectable/injectable.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:netflix_clone/domain/core/api_end_points.dart';
// import 'package:netflix_clone/domain/core/failures/main_failure.dart';
// import 'package:netflix_clone/domain/downloads/i_downloads_repo.dart';
// import 'package:netflix_clone/domain/downloads/models/downloads.dart';

// @LazySingleton(as: IDownloadsRepo)
// class DownloadsRepository implements IDownloadsRepo {
//   @override
//   Future<Either<MainFailure, List<Downloads>>> getDownloadsImages() async {
//     try {
//       final Response response =
//           await Dio(BaseOptions()).get(ApiEndpoints.downloads);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final downloadsList = (response.data['results'] as List).map((e) {
//           return Downloads.fromJson(e);
//         }).toList();

//         print(downloadsList);
//         return Right(downloadsList);
//       } else {
//         return const Left(MainFailure.serverFailure());
//       }
//     } catch (e) {
//       return const Left(MainFailure.clientFailure());
//     }
//   }

//   Future<Either<MainFailure, List<Downloads>>> getDownloadsImage() {
//     // ignore: todo
//     // TODO: implement getDownloadsImage
//     throw UnimplementedError();
//   }
// }
