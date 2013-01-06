# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-RewriteAttributes/HTML-RewriteAttributes-0.40.0.ebuild,v 1.1 2011/08/30 14:01:31 tove Exp $

EAPI=4

MODULE_AUTHOR=SARTAK
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Perl module for concise attribute rewriting"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/URI
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
