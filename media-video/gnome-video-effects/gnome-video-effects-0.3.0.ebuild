# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-video-effects/gnome-video-effects-0.3.0.ebuild,v 1.6 2012/03/25 16:54:23 armin76 Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Effects for Cheese, the webcam video and picture application"
HOMEPAGE="http://www.gnome.org/projects/cheese/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
DOCS="AUTHORS ChangeLog NEWS README"
