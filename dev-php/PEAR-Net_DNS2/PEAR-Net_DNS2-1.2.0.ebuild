# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNS2/PEAR-Net_DNS2-1.2.0.ebuild,v 1.1 2012/01/18 20:17:17 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Object-oriented PHP5 resolver library used to communicate with a DNS server."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/php[sockets]"
