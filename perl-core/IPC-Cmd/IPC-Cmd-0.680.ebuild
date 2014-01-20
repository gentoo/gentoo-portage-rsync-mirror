# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IPC-Cmd/IPC-Cmd-0.680.ebuild,v 1.4 2014/01/20 20:43:48 vapier Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.68
inherit perl-module

DESCRIPTION="Finding and running system commands made easy"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Locale-Maketext-Simple
	virtual/perl-Module-Load-Conditional
	>=virtual/perl-Params-Check-0.26"
RDEPEND="${DEPEND}"

SRC_TEST=do
