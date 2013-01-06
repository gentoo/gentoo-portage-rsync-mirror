# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WordNet-QueryData/WordNet-QueryData-1.490.0.ebuild,v 1.1 2011/08/28 08:56:05 tove Exp $

EAPI=4

MODULE_AUTHOR=JRENNIE
MODULE_VERSION=1.49
inherit perl-module

DESCRIPTION="Direct perl interface to WordNet database"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-dicts/wordnet"
RDEPEND="${DEPEND}"

src_configure() {
	export WNHOME=/usr
	perl-module_src_configure
}
