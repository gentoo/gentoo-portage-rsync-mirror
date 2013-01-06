# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do-plugins/gnome-do-plugins-0.8.4.ebuild,v 1.2 2012/05/05 06:25:18 jdhore Exp $

EAPI=2

inherit eutils gnome2 mono versionator

MY_PN="do-plugins"
PVC=$(get_version_component_range 1-3)

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/${MY_PN}/trunk/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="banshee"

RDEPEND=">=gnome-extra/gnome-do-${PV}
		dev-dotnet/wnck-sharp
		banshee? ( >=media-sound/banshee-1.4.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf --enable-debug=no --enable-release=yes \
		$(use banshee) \
		--disable-empathy \
		--disable-flickr || die "configure failed"
}

src_compile()
{
	# The make system is unfortunately broken for parallel builds and
	# upstream indicated on IRC that they have no intention to fix
	# that.
	emake -j1 || die "make failed"
}
