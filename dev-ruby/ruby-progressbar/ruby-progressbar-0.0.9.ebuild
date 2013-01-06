# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.0.9.ebuild,v 1.9 2012/10/07 16:49:41 armin76 Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="https://github.com/jfelchner/ruby-progressbar"

LICENSE="|| ( Ruby GPL-2 )"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~x86-fbsd"

IUSE="test"

each_ruby_test() {
	# tests need to be run from within the lib dir but they require
	# lib/progressbar.rb, so we do this silly stuff, but it works at
	# least
	cd lib
	${RUBY} -I.. ../test.rb || die "test failed"
}
