# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/heredoc_unindent/heredoc_unindent-1.1.2-r3.ebuild,v 1.2 2014/05/21 02:04:47 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 jruby"

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
