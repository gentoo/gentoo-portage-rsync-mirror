# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/blam/blam-1.8.6.ebuild,v 1.9 2012/05/03 04:28:53 jdhore Exp $

EAPI=2

inherit mono eutils

DESCRIPTION="A RSS aggregator written in C#"
HOMEPAGE="http://www.cmartin.tk/blam.html"
SRC_URI="http://www.cmartin.tk/blam/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2
	>=dev-dotnet/gtk-sharp-2.12.6
	>=dev-dotnet/glade-sharp-2.12.6
	>=dev-dotnet/gnome-sharp-2.16.1
	>=dev-dotnet/gconf-sharp-2.8.2
	>=dev-dotnet/webkit-sharp-0.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gconf-2.4"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.25"

# Disable parallel builds
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	# fix test suite
	echo "blam.desktop.in" >> po/POTFILES.in || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	mono_multilib_comply
}
