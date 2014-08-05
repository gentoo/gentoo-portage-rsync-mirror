# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby_parser/ruby_parser-2.3.1-r1.ebuild,v 1.11 2014/08/05 16:00:30 mrueg Exp $

EAPI=2

USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A ruby parser written in pure ruby"
HOMEPAGE="http://parsetree.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# Restrict tests because the test case does not load the right version
# of sexp_processor.
RESTRICT="test"

# The sexp-processor dependency is needed to make tests pass for ruby 1.9.
ruby_add_rdepend ">=dev-ruby/sexp_processor-3.0.9"
ruby_add_bdepend "doc? ( >=dev-ruby/hoe-2.9.1 )"
ruby_add_bdepend "test? ( >=dev-ruby/sexp_processor-3.0.6 )"

all_ruby_prepare() {
	# Remove reference to perforce method that is not in a released
	# version of hoe-seattlerb.
	sed -i -e '/perforce/d' Rakefile || die

	sed -i -e '/Hoe.plugin :isolate/ s:^:#:' Rakefile || die
}
