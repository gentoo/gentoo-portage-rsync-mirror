# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-backgrounds/gnome-backgrounds-3.4.2.ebuild,v 1.1 2012/08/10 11:19:27 eva Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A set of backgrounds packaged with the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	>=dev-util/intltool-0.40.0"

DOCS="AUTHORS ChangeLog NEWS README"
