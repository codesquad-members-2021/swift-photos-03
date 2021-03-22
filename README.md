# swift-photos-03
iOS 연습 - 3팀(Isaac, Downey)

![스크린샷 2021-03-22 오후 3.32.03](/Users/issac/Dropbox/masters/TIL/image/스크린샷 2021-03-22 오후 3.32.03.png)

### collecionView 생성

- 임시로 40개 cell 제작, random background를 만드는 메소드 구현

- Cell 크기를 80 x 80 로 지정

  `func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize)`

- AutoLayout 지정

### 이후 계획

- viewController에서 collectionView 분리 계획(`presenter` 혹은 `viewModel`)