# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_IMAP/PEAR-Net_IMAP-1.1.1.ebuild,v 1.8 2012/03/18 18:38:39 armin76 Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Provides an implementation of the IMAP protocol."

LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="sasl"
RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.8
	!sasl? ( >=dev-php/PEAR-Auth_SASL-1.0.2 )"
