# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sound-theme-freedesktop/sound-theme-freedesktop-0.8.ebuild,v 1.1 2012/12/25 12:24:23 pacho Exp $

EAPI="5"

DESCRIPTION="Default freedesktop.org sound theme following the XDG theming specification"
HOMEPAGE="http://www.freedesktop.org/wiki/Specifications/sound-theme-spec"
SRC_URI="http://people.freedesktop.org/~mccann/dist/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2 CCPL-Attribution-3.0 CCPL-Attribution-ShareAlike-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="sys-devel/gettext
	dev-libs/glib:2
	>=dev-util/intltool-0.40"
