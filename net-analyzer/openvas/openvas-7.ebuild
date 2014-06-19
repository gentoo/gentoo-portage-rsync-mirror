# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas/openvas-7.ebuild,v 1.1 2014/06/19 13:39:24 hanno Exp $

EAPI=5

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
DEPEND=">=net-analyzer/openvas-libraries-7.0.2
	>=net-analyzer/openvas-scanner-4.0.1
	>=net-analyzer/openvas-manager-5.0.2
	>=net-analyzer/openvas-cli-1.3.0
	>=net-analyzer/greenbone-security-assistant-5.0.1"
# greenbone-security-desktop is broken and unsupported upstream
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
