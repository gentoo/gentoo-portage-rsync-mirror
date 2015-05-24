# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/semantic_puppet/semantic_puppet-0.1.1.ebuild,v 1.1 2015/05/24 22:54:59 robbat2 Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem

DESCRIPTION="Library of useful tools for working with Semantic Versions and module dependencies."
HOMEPAGE="https://github.com/puppetlabs/semantic_puppet"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

all_ruby_prepare() {
	# ignore faulty metadata
	rm -f ../metadata || die

}
