# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Attachment-Stripper/Email-MIME-Attachment-Stripper-1.317.0.ebuild,v 1.1 2013/09/03 04:40:05 patrick Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.317
inherit perl-module

DESCRIPTION="Strip the attachments from a mail"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
# under the same terms as Tony's original module
# Mail::Message::Attachment::Stripper
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Email-MIME-1.900
	>=dev-perl/Email-MIME-ContentType-1.012"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
