# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitg/gitg-0.1.0.ebuild,v 1.4 2012/06/09 14:29:42 sping Exp $

EAPI="3"

inherit gnome2

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="http://git.gnome.org/browse/gitg/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/gtksourceview-2.8:2.0
	>=gnome-base/gconf-2.10:2
	>=gnome-base/gsettings-desktop-schemas-0.1.1
	dev-vcs/git"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	>=dev-util/intltool-0.40"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--with-gtk=2.0"

	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	# Fix intltoolize broken file, see <https://bugzilla.gnome.org/show_bug.cgi?id=577133>
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i "${S}/po/Makefile.in.in" || die "sed failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "Removal of .la files failed"
}

src_test() {
	emake check || die
}
