# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Quota/Quota-1.700.0.ebuild,v 1.1 2013/08/25 10:50:43 patrick Exp $

EAPI=4

MODULE_AUTHOR=TOMZO
MODULE_VERSION=1.7.0
inherit perl-module

DESCRIPTION="Quota - Perl interface to file system quotas"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

# Tests need real FS access/root permissions and are interactive
SRC_TEST="skip"

src_prepare() {
	# disable AFS completely for now, need somebody who can really test it
	sed -i -e 's|-d "/afs"|0|' Makefile.PL || die "sed failed"
}
