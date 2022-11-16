[ -d $HOME/.config ] || mkdir $HOME/.config
echo $COPR_BASE64 | base64 -d > $HOME/.config/copr
mkdir /tmp/results
docker run -v $PWD:/workdir -v /tmp/results:/tmp/results quay.io/karmab/rpkg --path /workdir srpm --outdir /tmp/results --spec /workdir/assisted-service-client.spec
copr-cli build --nowait aicli /tmp/results/assisted-service-client*.rpm
docker run -v $PWD:/workdir -v /tmp/results:/tmp/results quay.io/karmab/rpkg --path /workdir srpm --outdir /tmp/results --spec /workdir/aicli.spec
copr-cli build --nowait aicli /tmp/results/aicli*src.rpm
