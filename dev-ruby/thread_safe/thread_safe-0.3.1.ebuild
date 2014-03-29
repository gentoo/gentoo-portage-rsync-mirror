# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/thread_safe/thread_safe-0.3.1.ebuild,v 1.1 2014/03/29 10:21:50 graaff Exp $

EAPI=5
# jruby → there is code for this in ext but that requires compiling java.
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A collection of thread-safe versions of common core Ruby classes"
HOMEPAGE="https://github.com/headius/thread_safe"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

# Higher atomic dependency since earlier versions crash on ruby20 while
# running thread_safe tests.
ruby_add_rdepend ">=dev-ruby/atomic-1.1.16"

each_ruby_prepare(){
	sed -i -e "/[Bb]undler/d" Rakefile || die
}
