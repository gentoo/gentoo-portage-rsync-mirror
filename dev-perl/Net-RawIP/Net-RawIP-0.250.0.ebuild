# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-RawIP/Net-RawIP-0.250.0.ebuild,v 1.2 2011/09/03 21:05:27 tove Exp $

EAPI=4

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.25
inherit perl-module

DESCRIPTION="Perl Net::RawIP - Raw IP packets manipulation Module"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="net-libs/libpcap"
DEPEND="${RDEPEND}"
