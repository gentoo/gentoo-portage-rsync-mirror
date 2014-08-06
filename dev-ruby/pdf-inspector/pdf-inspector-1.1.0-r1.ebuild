# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-inspector/pdf-inspector-1.1.0-r1.ebuild,v 1.2 2014/08/06 02:01:37 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="A tool for analyzing PDF output"
HOMEPAGE="https://github.com/prawnpdf/pdf-inspector"

LICENSE="|| ( Ruby GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/pdf-reader-1.0"
