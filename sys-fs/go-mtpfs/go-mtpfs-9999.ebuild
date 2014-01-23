# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/go-mtpfs/go-mtpfs-9999.ebuild,v 1.4 2014/01/23 17:16:38 zerochaos Exp $

EAPI=5

inherit git-r3 flag-o-matic toolchain-funcs

DESCRIPTION="a simple FUSE filesystem for mounting Android devices as a MTP device"
HOMEPAGE="https://github.com/hanwen/go-mtpfs"
EGIT_REPO_URI="https://github.com/hanwen/go-mtpfs.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="virtual/libusb
		media-libs/libmtp"
DEPEND="${COMMON_DEPEND}
	dev-libs/go-fuse
	dev-lang/go"
RDEPEND="${COMMON_DEPEND}"

GO_PN="github.com/hanwen/${PN}"
EGIT_CHECKOUT_DIR="${S}/src/${GO_PN}"

export GOPATH="${S}"
export GOGCCFLAGS="${CFLAGS}"

#pkg_setup() {
#}

src_compile() {
	#if gcc-specs-pie ; then
	#	filter-flags -fPIE
	#	append-ldflags -nopie
	#fi
	go build -ldflags '-nopie' -v -x -work ${GO_PN}/fs || die
	go build -ldflags '-nopie' -v -x -work ${GO_PN}/usb || die
	go build -ldflags '-nopie' -v -x -work ${GO_PN}/mtp || die
#works on hardened up to here
	go build -ldflags '-extldflags=-fno-PIC' -v -x -work ${GO_PN} || die
}

src_test() {
#none of this works on hardened
	go test ${GO_PN}/fs || die
	go test ${GO_PN}/usb || die
	go test ${GO_PN}/mtp || die
}

src_install() {
#	go install -v -x -work ${GO_PN}/fs || die
#	go install -v -x -work ${GO_PN}/usb || die
#	go install -v -x -work ${GO_PN}/mtp || die
	go install -ldflags '-extldflags=-fno-PIC' -v -x -work ${GO_PN} || die
}

#please don't remove commented lines till it works in hardened
