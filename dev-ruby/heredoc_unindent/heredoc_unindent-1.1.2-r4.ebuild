# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heredoc_unindent/heredoc_unindent-1.1.2-r4.ebuild,v 1.2 2015/03/20 15:36:15 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

inherit ruby-fakegem

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_EXTRADOC="README.rdoc History.rdoc Wishlist.rdoc"
DESCRIPTION="Removes leading whitespace from Ruby heredocs"
HOMEPAGE="https://github.com/adrianomitre/heredoc_unindent"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc test"

ruby_add_bdepend "test? ( >=dev-ruby/hoe-2.8.0 dev-ruby/test-unit:2 )
	doc? ( >=dev-ruby/hoe-2.8.0 )"

all_ruby_prepare() {
	sed -i -e '1igem "test-unit"' test/test_heredoc_unindent.rb || die
}
