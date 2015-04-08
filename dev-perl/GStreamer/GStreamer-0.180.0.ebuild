# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GStreamer/GStreamer-0.180.0.ebuild,v 1.3 2013/05/15 14:14:33 ago Exp $

EAPI=5

MODULE_AUTHOR=XAOC
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="Perl bindings for GStreamer"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

RDEPEND="
	media-libs/gstreamer:0.10
	>=dev-perl/glib-perl-1.180.0
"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205.0
	>=dev-perl/extutils-pkgconfig-1.70.0
	virtual/pkgconfig
"

SRC_TEST=do
