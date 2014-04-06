# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.0.10.ebuild,v 1.11 2014/04/05 23:27:38 mrueg Exp $

EAPI=3

USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="none"
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
	${RUBY} -I. test.rb || die "test failed"
}
