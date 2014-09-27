# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.430.0.ebuild,v 1.2 2014/09/27 11:32:21 maekke Exp $

EAPI=5

MODULE_AUTHOR=BORISZ
MODULE_VERSION=1.43
inherit perl-module multilib

DESCRIPTION="Look up country by IP Address"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/geoip"
RDEPEND="${DEPEND}"

SRC_TEST=do
myconf="LIBS=-L/usr/$(get_libdir)"
