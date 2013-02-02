# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-video-effects/gnome-video-effects-0.4.0.ebuild,v 1.8 2013/02/02 22:59:21 ago Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Effects for Cheese, the webcam video and picture application"
HOMEPAGE="http://www.gnome.org/projects/cheese/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
DOCS="AUTHORS ChangeLog NEWS README"
