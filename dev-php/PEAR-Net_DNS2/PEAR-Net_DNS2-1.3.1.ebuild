# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_DNS2/PEAR-Net_DNS2-1.3.1.ebuild,v 1.1 2013/11/21 20:33:32 mabi Exp $

EAPI="5"

inherit php-pear-r1

DESCRIPTION="Object-oriented PHP5 resolver library used to communicate with a DNS server."
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/php[sockets]"
