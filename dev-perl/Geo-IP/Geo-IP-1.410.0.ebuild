# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Geo-IP/Geo-IP-1.410.0.ebuild,v 1.9 2013/06/29 16:19:46 ago Exp $

EAPI=5

MODULE_AUTHOR=BORISZ
MODULE_VERSION=1.41
inherit perl-module multilib

DESCRIPTION="Look up country by IP Address"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/geoip"
RDEPEND="${DEPEND}"

SRC_TEST=no
myconf="LIBS=-L/usr/$(get_libdir)"
