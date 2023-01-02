///An extension to filter a list of contents of  a stream based on provided parameters
///eg getting the notes of a particular user id from a strream of all users notes
///T stands for the stream item eg Database note
extension Filter<T> on Stream<List<T>> {
  ///the items that pass the parameters (filter) are then inluded in the final List
  Stream<List<T>> filter(bool Function(T) where) => map(
        (items) => items.where(where).toList(),
      );
}
