# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-WorkflowDatabaseTiein/ezc-WorkflowDatabaseTiein-1.4.ebuild,v 1.1 2011/12/14 22:27:56 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component contains the database backend for the Workflow component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Workflow-1.4
	>=dev-php/ezc-Database-1.3"
