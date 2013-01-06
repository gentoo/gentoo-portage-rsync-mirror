# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Statement/SQL-Statement-1.31.ebuild,v 1.10 2012/09/09 16:37:12 armin76 Exp $

EAPI=3

MODULE_AUTHOR=REHSACK
inherit perl-module

DESCRIPTION="Small SQL parser and engine"

SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="test"

RDEPEND=">=dev-perl/DBI-1.612
	>=dev-perl/Clone-0.30
	>=dev-perl/Params-Util-0.35
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"

pkg_setup() {
	export SQL_STATEMENT_WARN_UPDATE=sure

	if has_version "<=dev-perl/SQL-Statement-1.20" ; then
		ewarn "Changes include (1.22):"
		ewarn "  * behavior for unquoted identifiers modified to lower case them"
		ewarn "  * IN and BETWEEN operators are supported native"
	fi
}
