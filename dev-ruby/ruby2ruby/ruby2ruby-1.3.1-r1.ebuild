# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby2ruby/ruby2ruby-1.3.1-r1.ebuild,v 1.4 2013/09/15 09:57:18 ago Exp $

EAPI=2

USE_RUBY="ruby18"

# Don't run tests, since they require the testcase from ParseTree;
# ParseTree _is_ the testcase for ruby2ruby
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Generates readable ruby from ParseTree"
HOMEPAGE="http://seattlerb.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "=dev-ruby/parsetree-3*
	=dev-ruby/sexp_processor-3*
	=dev-ruby/ruby_parser-2*"
ruby_add_bdepend doc "dev-ruby/hoe dev-ruby/hoe-seattlerb"

all_ruby_prepare() {
	sed -i -e '/isolate/d' Rakefile || die
}
