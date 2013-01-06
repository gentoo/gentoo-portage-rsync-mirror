# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Exporter/Sub-Exporter-0.984.0.ebuild,v 1.9 2012/12/31 16:56:43 ago Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.984
inherit perl-module

DESCRIPTION="A sophisticated exporter for custom-built routines"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	>=dev-perl/Sub-Install-0.920.0
	>=dev-perl/Data-OptList-0.100.0
	>=dev-perl/Params-Util-0.140.0
"
DEPEND="${RDEPEND}"

SRC_TEST=do
