# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp-xsl/yelp-xsl-3.4.2.ebuild,v 1.9 2013/02/06 05:08:43 tetromino Exp $

EAPI="4"

inherit gnome.org

DESCRIPTION="XSL stylesheets for yelp"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2+ LGPL-2.1+ MIT FDL-1.1+"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.8"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/itstool
	sys-devel/gettext
	virtual/awk
	virtual/pkgconfig"
