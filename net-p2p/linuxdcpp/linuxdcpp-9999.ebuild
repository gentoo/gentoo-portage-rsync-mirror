# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/linuxdcpp/linuxdcpp-9999.ebuild,v 1.17 2014/11/21 09:48:26 vapier Exp $

EAPI="1"

# TODO: This needs to use the escons eclass.
inherit bzr eutils multiprocessing

DESCRIPTION="Direct connect client, looks and works like famous DC++"
HOMEPAGE="https://launchpad.net/linuxdcpp"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

EBZR_REPO_URI="lp:linuxdcpp"

S=${WORKDIR}/${P}

RDEPEND=">=gnome-base/libglade-2.4:2.0
	>=x11-libs/gtk+-2.6:2
	app-arch/bzip2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	media-libs/fontconfig
	>=dev-util/scons-0.96
	virtual/pkgconfig
	>=dev-libs/boost-1.35.0-r2"

src_compile() {
	local myconf=""
	use debug && myconf="${myconf} debug=1"

	scons ${myconf} -j$(makeopts_jobs) CXXFLAGS="${CXXFLAGS}" PREFIX=/usr || die "scons failed"
}

src_install() {
	# linuxdcpp does not install docs according to gentoos naming scheme, so do it by hand
	dodoc Readme.txt Changelog.txt Credits.txt
	rm "${S}"/*.txt

	scons install PREFIX="/usr" FAKE_ROOT="${D}" || die "scons install failed"
}

pkg_postinst() {
	elog
	elog "After adding first directory to shares you might need to restart linuxdcpp."
	elog
}
