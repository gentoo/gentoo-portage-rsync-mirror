# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_loopback/mod_loopback-2.01-r1.ebuild,v 1.1 2007/07/29 14:18:03 phreak Exp $

inherit apache-module

KEYWORDS="ppc ppc64 x86"

DESCRIPTION="A web client debugging tool for Apache2."
HOMEPAGE="http://www.snert.com/Software/mod_loopback/index.shtml"
SRC_URI="http://www.snert.com/Software/download/${PN}201.tgz"
LICENSE="as-is"
SLOT="2"
IUSE=""

S="${WORKDIR}/${PN}-2.1"

APACHE2_MOD_CONF="28_mod_loopback"
APACHE2_MOD_DEFINE="LOOPBACK"

DOCFILES="CHANGES.TXT LICENSE.TXT"

need_apache2
