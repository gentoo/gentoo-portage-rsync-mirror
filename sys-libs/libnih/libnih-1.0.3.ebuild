# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libnih/libnih-1.0.3.ebuild,v 1.4 2012/05/24 05:13:29 vapier Exp $

EAPI="2"

inherit versionator eutils autotools toolchain-funcs

DESCRIPTION="Light-weight 'standard library' of C functions"
HOMEPAGE="https://launchpad.net/libnih"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+dbus nls static-libs test +threads"

RDEPEND="dbus? ( dev-libs/expat >=sys-apps/dbus-1.2.16 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-util/valgrind )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.3-optional-dbus.patch
	epatch "${FILESDIR}"/${PN}-1.0.3-pkg-config.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_with dbus) \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable threads) \
		$(use_enable threads threading)
}

src_install() {
	emake DESTDIR="${D}" install || die

	# we need to be in / because upstart needs libnih
	gen_usr_ldscript -a nih $(use dbus && echo nih-dbus)
	use static-libs || rm "${D}"/usr/lib*/*.la

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
