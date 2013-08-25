# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-LocalDelivery/Email-LocalDelivery-1.200.0.ebuild,v 1.1 2013/08/25 07:55:28 patrick Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.200
inherit perl-module

DESCRIPTION="Local delivery of RFC2822 message format and headers"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Email-Simple
	dev-perl/Email-FolderType
	dev-perl/File-Path-Expand"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
