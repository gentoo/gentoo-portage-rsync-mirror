# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-rrd/pecl-rrd-1.0.5.ebuild,v 1.1 2012/02/22 22:04:03 mabi Exp $

EAPI=4

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="RRDtool bindings for PHP"
LICENSE="BSD"

SLOT="0"
IUSE=""

DEPEND=">=net-analyzer/rrdtool-1.4.5-r1"
RDEPEND="${DEPEND}"
