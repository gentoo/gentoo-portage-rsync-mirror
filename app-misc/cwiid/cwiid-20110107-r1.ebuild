# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cwiid/cwiid-20110107-r1.ebuild,v 1.5 2013/02/10 02:49:41 ottxor Exp $

EAPI="3"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/abstrakraft/cwiid.git"
	SRC_URI=""
	KEYWORDS=""
	inherit git
else
	# git archive --prefix=cwiid-$(date +%Y%m%d)/ \
	#	--format=tar HEAD | bzip2 > cwiid-$(date +%Y%m%d).tar.bz2
	SRC_URI="http://dev.gentoo.org/~lxnay/cwiid/cwiid-${PV}.tar.bz2"
	KEYWORDS="~x86 ~amd64"
fi

inherit eutils linux-mod autotools

DESCRIPTION="Library, input driver, and utilities for the Nintendo Wiimote"
HOMEPAGE="http://abstrakraft.org/cwiid"

LICENSE="GPL-2"
SLOT="0"
IUSE="python"

DEPEND="virtual/awk
	sys-apps/sed
	sys-devel/bison
	>=sys-devel/flex-2.5.35
	virtual/pkgconfig"

RDEPEND="net-wireless/bluez
	x11-libs/gtk+:2
	python? ( >=dev-lang/python-2.4 )"

pkg_setup() {
	CONFIG_CHECK="BT_L2CAP INPUT_UINPUT"
	linux-mod_pkg_setup
}

src_unpack() {
	if [[ ${PV} == "9999" ]]; then
		git_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	# Fix broken build system
	sed -i "s:--disable-ldconfig:--without-ldconfig:g" "${S}"/configure.ac || die
	sed -i "s:enable_ldconfig:with_ldconfig:g" "${S}"/configure.ac || die
	epatch "${FILESDIR}"/${P}-underlinking.patch
	eautoreconf
}
src_configure() {
	econf $(use_with python) --without-ldconfig || die "configure failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	insinto /lib/udev/rules.d
	doins "${FILESDIR}/60-${PN}.rules"
}
