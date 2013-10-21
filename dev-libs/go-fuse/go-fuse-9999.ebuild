# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/go-fuse/go-fuse-9999.ebuild,v 1.3 2013/10/21 01:21:10 zerochaos Exp $

EAPI=5

inherit git-r3

RESTRICT="strip"

DESCRIPTION="native bindings for the FUSE kernel module"
HOMEPAGE="https://github.com/hanwen/go-fuse"
EGIT_REPO_URI="https://github.com/hanwen/go-fuse.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/go"
RDEPEND=""

GO_PN="github.com/hanwen/${PN}"
EGIT_CHECKOUT_DIR="${S}/src/${GO_PN}"

export GOPATH="${S}"

src_compile() {
#no examples right now
#    example/hello example/loopback example/zipfs \
#    example/multizip example/unionfs example/memfs \
#    example/autounionfs ; \
#or tests
#fuse/test
for d in fuse fuse/pathfs zipfs unionfs
do
	go build -v -x -work ${GO_PN}/${d} || die
done
}

src_install() {
for d in fuse fuse/pathfs zipfs unionfs
do
	go install -v -x -work ${GO_PN}/${d} || die
done

insinto /usr/lib/go/
doins -r "${S}/pkg"
insinto /usr/lib/go/src/pkg
doins -r "${S}/src/."
}
