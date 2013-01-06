# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Jabber/Net-Jabber-2.0.0.ebuild,v 1.3 2012/09/06 01:38:42 blueness Exp $

EAPI=4

MODULE_AUTHOR=REATMON
MODULE_VERSION=2.0
inherit perl-module

DESCRIPTION="Jabber Perl library"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/XML-Stream
	dev-perl/Net-XMPP
	dev-perl/Digest-SHA1"
DEPEND="${RDEPEND}"

SRC_TEST="do"
