# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 flag-o-matic multilib toolchain-funcs

DESCRIPTION="CGO bindings for libusb"
HOMEPAGE="https://github.com/hanwen/usb"
EGIT_REPO_URI="https://github.com/hanwen/usb.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="virtual/libusb
		virtual/udev"
DEPEND="${COMMON_DEPEND} 
		dev-lang/go"

RDEPEND="${COMMON_DEPEND}"

# Tests require a connected mtp device
RESTRICT="test"

GO_PN="/usr/$(get_libdir)/go/src/github.com/hanwen/usb"

src_install() {
	dodir "${GO_PN}"

	rm -r "${S}/.git" || die "Failed to remove .git directory"

	for i in LICENSE *.go; do
		cp "${S}/${i}" "${D}/${GO_PN}" || die "Install failed"
	done
}

src_test() {
	go test -ldflags '-extldflags=-fno-PIC' ${GO_PN} || die
}

