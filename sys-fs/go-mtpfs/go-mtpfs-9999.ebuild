# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/go-mtpfs/go-mtpfs-9999.ebuild,v 1.2 2013/10/21 01:01:11 zerochaos Exp $

EAPI=5

inherit git-r3

DESCRIPTION="a simple FUSE filesystem for mounting Android devices as a MTP device"
HOMEPAGE="https://github.com/hanwen/go-mtpfs"
EGIT_REPO_URI="https://github.com/hanwen/go-mtpfs.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="virtual/libusb"
DEPEND="${COMMON_DEPEND}
	dev-libs/go-fuse
	dev-lang/go"
RDEPEND="${COMMON_DEPEND}"

GO_PN="github.com/hanwen/${PN}"
EGIT_CHECKOUT_DIR="${S}/src/${GO_PN}"

export GOPATH="${S}"

src_compile() {
	go build -v -x -work ${GO_PN} || die
}

src_install() {
	go install -v -x -work ${GO_PN} || die
}
