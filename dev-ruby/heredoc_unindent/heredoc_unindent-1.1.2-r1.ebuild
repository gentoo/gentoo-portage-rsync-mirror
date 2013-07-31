# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heredoc_unindent/heredoc_unindent-1.1.2-r1.ebuild,v 1.1 2013/07/31 04:45:48 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19"

inherit ruby-fakegem

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_EXTRADOC="README.rdoc History.rdoc Wishlist.rdoc"
DESCRIPTION="Removes leading whitespace from Ruby heredocs"
HOMEPAGE="https://github.com/adrianomitre/heredoc_unindent"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

ruby_add_bdepend "test? ( >=dev-ruby/hoe-2.8.0 )
	doc? ( >=dev-ruby/hoe-2.8.0 )"
