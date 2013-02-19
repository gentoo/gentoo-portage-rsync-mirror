# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Data-Dumper/Data-Dumper-2.139.0.ebuild,v 1.5 2013/02/18 23:34:45 ago Exp $

EAPI=4

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=2.139
inherit perl-module

DESCRIPTION="Stringified perl data structures, suitable for both printing and eval"

SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"
