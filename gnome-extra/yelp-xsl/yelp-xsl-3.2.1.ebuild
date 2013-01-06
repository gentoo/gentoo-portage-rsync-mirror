# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp-xsl/yelp-xsl-3.2.1.ebuild,v 1.5 2012/12/16 10:12:24 tetromino Exp $

EAPI="4"

inherit gnome.org

DESCRIPTION="XSL stylesheets for yelp"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2+ LGPL-2.1+ MIT FDL-1.1+"
SLOT="0"
KEYWORDS="amd64 ~mips x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.8"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-devel/gettext
	>=dev-util/intltool-0.40
	dev-util/itstool
	virtual/pkgconfig"
